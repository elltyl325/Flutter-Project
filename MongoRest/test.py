#!/usr/bin/python

import requests
import sys
import os
import argparse
import json

SITE_URL = ""


def test_get_all():
    print("[*]Testing for /getAll endpoint")
    try:
        response = requests.get(SITE_URL + "/getAll")
        assert len(response.json()) == 10, "[!]\tYou should only have ten documents being returned"
    except AssertionError:
        print("[!]\tFailure, resolve before continuing tests. Length of documents was not correct. Please only return 10 documents. See the limit function of mongo")
        sys.exit()
    print("\tReceived all documents")


def test_create():
    print("[*] Testing the /createCollection endpoint")
    try:
        data= '''{
                "name" : "test"
            }'''
        r = requests.post(SITE_URL + "/createCollection", json={"name":"test"})
        assert (r.status_code == 409 or r.status_code == 201), "[!]\tResponse code sent back is incorrect"
        if r.status_code == 409:
            print("\tCollection exists")
        elif r.status_code == 201:
            print("\tCreated")
    except AssertionError:
        print("[!]\tFailure response code sent back was incorrect")
        print("[!]\t\tFailure, test failed resolve before continuing tests.")
        sys.exit()

    print("\tReceived appropriate documents")


def test_get(length = 0):
    print("[*] Testing /getCollection endpoint")
    try:
        data = '''{
            "name" : "asdfasd"
            }'''
        r = requests.post(SITE_URL + "/getCollection", json={"name":"asdfsa"})
        if length > 0:
            assert len(r.json()) > length, "[!]\tDB wasn't updated from previous query"
        assert len(r.json()) >= 0, "[!]\tError determining if collection exists"
        print("\tCollection exists")
        return len(r.json())
    except AssertionError:
        print("[!]\tDB wasn't updated error")
        print("[!]\t\tFailure, resolve before continuing tests")
        sys.exit()

def test_insert():
    print("[*] Testing /insertToCollection")
    try:
        data='''{
            "name" : "test",
            "hash" : "b73d24921dea5462a00357f25e9f92c2",
            "other": {
                "id1": "junk",
                "id2": "junk"
            }

        }'''

        r = requests.post(SITE_URL + "/insertToCollection", json=json.loads(data))
        js = r.json()
        print("\t" , js)
        assert js['hash'] == "b73d24921dea5462a00357f25e9f92c2" and js['other']['id1'] == "junk" and js['other']['id2'] == "junk", "Inserted value is not sent back in response"
    except AssertionError:
        print("[!]\t\tFailure, resolve before continuing tests")
        sys.exit()


def run_tests():
    try:
        test_get_all()
        test_create()
        l = test_get()
        test_insert()
        test_get(l)
    except requests.HTTPError as er:
        print("[!] HTTP error: {}".format(er))
    except requests.ConnectionError as er:
        print("[!] Connection error, check ports/endpoints")
    except json.JSONDecodeError as er:
        print("[!] Something went wrong with response data {}".format(er))
    except ValueError as er:
        print("[!]\t\tJson value error, this should not happen if sending back query docs: {}".format(er))
    except:
        print("[!] Bad error please check your code")
    else:
        print("[*]\b All tests have succeeded run this script with --submit to complete the lab")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Test script to validate your server')
    parser.add_argument('-u', metavar='port', type=str, help='url of node server (Do not add http:// that will be added to the ip/url)')

    parser.add_argument('-p', metavar='port', type=str, help='port of node server')

    args = parser.parse_args()
    if args.u is None:
        parser.print_help()
        sys.exit(1)
    if "http" in args.u and args.p:
        SITE_URL = "{}:{}".format(args.u, args.p)
        print(SITE_URL)
        run_tests()
    if args.p and args.u:
        SITE_URL = "http://{}:{}".format(args.u, args.p)
        print(SITE_URL)
        run_tests()

