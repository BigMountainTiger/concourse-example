import unittest
from src.app import lambdaHandler

class TestLambdafunction(unittest.TestCase):

    result = lambdaHandler(None, None)
    print(result)
