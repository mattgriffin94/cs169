"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib

class TestAddExistingUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
            Check that the response data dictionary matches the expected values
            """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    
    def testAddExistingUser(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'matt', 'password' : 'griffin'} )
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'matt', 'password' : 'griffin'} )
        self.assertResponse(respData,count=None, errCode = testLib.RestTestCase.ERR_USER_EXISTS)

class TestAddEmptyUserString(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
            Check that the response data dictionary matches the expected values
            """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    
    def testAddEmptyUserString(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'griffin'} )
        self.assertResponse(respData,count=None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

class TestAddLongUserString(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
            Check that the response data dictionary matches the expected values
            """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    
    def testAddLongUserString(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'z'*129, 'password' : 'griffin'} )
        self.assertResponse(respData,count=None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

class TestAddLongPasswordString(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
            Check that the response data dictionary matches the expected values
            """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    
    def testAddLongPasswordString(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'z', 'password' : 'griffin'*100} )
        self.assertResponse(respData,count=None, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD)

class TestLoginUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
            Check that the response data dictionary matches the expected values
            """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    
    def testLoginUser(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'test2', 'password' : 'pass2'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'test2', 'password' : 'pass2'} )
        self.assertResponse(respData,count=2)

class TestLoginUserDoesntExist(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
            Check that the response data dictionary matches the expected values
            """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    
    def testLoginUserDoesntExist(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'hahaha', 'password' : 'pass2'} )
        self.assertResponse(respData,count=None,errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)



    
