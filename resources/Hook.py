import json
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn, RobotNotRunningError
import requests


class Hook:
    def __init__(self):
        self._builtin = None

    @property
    def builtin(self):
        if not self._builtin:
            try:
                self._builtin = BuiltIn()
            except RobotNotRunningError:
                self._builtin = None
        return self._builtin

    @keyword('prepare payload')
    def prepare_payload(self, data_file: str, key: str):
        with open(data_file, 'r', encoding='utf-8') as of:
            json_data = json.load(of)
            test_data = json_data["data"][key]
        return test_data

    @keyword('post request')
    def post_request(self, url: str, payload, auth: dict = None):
        json_object = json.dumps(payload)
        resp = requests.post(url=url, json=json.loads(json_object), params=auth)
        self.builtin.set_test_variable('${RESPONSE}', resp)

    @keyword('verify status code')
    def verify_status_code(self, expected_status_code, actual_status_code):
        try:
            assert str(expected_status_code) == str(actual_status_code)
        except AssertionError:
            err = f'Expected status code is {expected_status_code}, however actual status code is {actual_status_code}'
            raise AssertionError(err)

    @keyword('delete request')
    def delete_request(self, url: str, dict_data: dict = None):
        resp = requests.delete(url=url, params=dict_data)
        self.builtin.set_test_variable('${RESPONSE}',resp)

    @keyword('Convert Json to Dictionary')
    def convert_json_to_dictionary(self, json_body):
        return json.loads(json_body)

