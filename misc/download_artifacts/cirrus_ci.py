import argparse
import requests
from gql import gql, Client
from gql.transport.aiohttp import AIOHTTPTransport


def _fetch_file_paths(build_id: str) -> list[dict[str, str]]:
  transport = AIOHTTPTransport(url="https://api.cirrus-ci.com/graphql")

  client = Client(transport=transport, fetch_schema_from_transport=True)

  query = gql(
      """
      query BuildByIdQuery($buildID: ID!) {
        build(id: $buildID) {
          tasks {
            id
            artifacts {
              name
              files {
                path
              }
            }
          }
        }
      }
  """,
  )

  result = client.execute(query, variable_values={"buildID": build_id})

  task_id_and_paths = []
  for task in result["build"]["tasks"]:
    for artifact in task["artifacts"]:
      for file_info in artifact["files"]:
        path = file_info["path"]
        if path.endswith(".tar.gz"):
          task_id_and_paths.append({"task_id": task["id"], "path": f"{artifact['name']}/{path}"})

  return task_id_and_paths


def _download_file_from_path(task_id: str, path: str):
  download_url = f"https://api.cirrus-ci.com/v1/artifact/task/{task_id}/{path}"
  print(download_url)
  response = requests.get(download_url)
  if response.status_code != 200:
    raise FileNotFoundError
  open(path.split("/")[2], "wb").write(response.content)


def main():
  parser = argparse.ArgumentParser(description="CirrusCI artifacts downloader")
  parser.add_argument("--build_id", type=str, required=True, help="CirrusCI build ID")
  args = parser.parse_args()

  for task_id_and_path in _fetch_file_paths(args.build_id):
    _download_file_from_path(task_id_and_path["task_id"], task_id_and_path["path"])


if __name__ == "__main__":
  # 5174548709507072
	main()
