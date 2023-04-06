import json
import numpy as np


def lambdaHandler(event, context):

    print(event)
    print(context)

    result = np.random.randint(2, size=10).tolist()
    print(result)

    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }
