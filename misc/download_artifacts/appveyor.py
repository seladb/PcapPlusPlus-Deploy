import os
import argparse
import requests
import zipfile


def _fetch_file_paths(headers: dict) -> list[str]:
  appveyor_api_url = "https://ci.appveyor.com/api"
  download_urls = []
  response = requests.get(f"{appveyor_api_url}/projects/seladb/pcapplusplus-deploy", headers=headers)
  for job in response.json()["build"]["jobs"]:
    job_id = job["jobId"]
    artifacts_url = f"{appveyor_api_url}/buildjobs/{job_id}/artifacts"
    response = requests.get(artifacts_url, headers=headers)
    for artifact in response.json():
      file_name = artifact["fileName"]
      download_urls.append(f"{artifacts_url}/{file_name}")

  return download_urls


def _download_artifact(download_url: str, headers: dict):
  print(download_url)
  response = requests.get(download_url, headers=headers)
  if response.status_code != 200:
    raise FileNotFoundError(response.json())
  zip_file_name = "appveyor_artifact.zip"
  open(zip_file_name, "wb").write(response.content)
  rename = None
  try:
    with zipfile.ZipFile(zip_file_name, "r") as zip_file:
      if download_url.endswith("VS-Package.zip"):
        rename = zip_file.namelist()[0].split("/")[0] + ".zip"
      else:
        zip_file.extractall()
  finally:
    if rename:
      os.rename(zip_file_name, rename)
    else:
      os.remove(zip_file_name)


def main():
  parser = argparse.ArgumentParser(description="AppVeyor artifacts downloader")
  parser.add_argument("--api_key", type=str, required=True, help="AppVeyor API key")
  args = parser.parse_args()

  headers = {"Authorization": f"Bearer {args.api_key}"}
  download_urls = _fetch_file_paths(headers)
  for url in download_urls:
    _download_artifact(url, headers)


if __name__ == "__main__":
  # v2.ssvjgsa5od9gkoj1mjgx
	main()
