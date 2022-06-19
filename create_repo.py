import requests
import os
import sys
import argparse
import json
from dotenv import load_dotenv

load_dotenv()

def create_repo(args):
    headers = {
        "Authorization": "token {}".format(os.getenv("TOKEN"))
    }

    payload = {
        "name": args.name,
        "private": args.private
    }

    resp = requests.post("https://api.github.com/user/repos", headers=headers, data=json.dumps(payload))
    if resp.status_code >= 200:
        print("Repo {} created".format(args.name))
    else:
        print("Error in creating repo {}".format(args.name))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description = "Create a github repo")
    parser.add_argument("--name", type=str, help="Specify name of the repository to create", required=True)
    parser.add_argument("--private", type=bool, help="Specify whether the repo should be private or not", default=False)

    args = parser.parse_args()
    create_repo(args)