import json
import sys

def toBool(value) :
    return value in ['True', 'true'] 

if len(sys.argv) <> 6 :
    raise NameError("Invalid arguments count " + len(sys.argv))

fileName = "./BattleBorder/Resources/data/settings.json"
jsonFile = open(fileName, "r")
data = json.load(jsonFile)
jsonFile.close()

data["SERVER_URL"] = sys.argv[1]
data["OFFLINE_MODE"] = toBool(sys.argv[2])
data["EDITOR_MODE"] = toBool(sys.argv[3])
data["LOGGING_ENABLED"] = toBool(sys.argv[4])
data["FAKE_TUTORIAL_STEP"] = int(sys.argv[5])

jsonFile = open(fileName, "w+")
jsonFile.write(json.dumps(data))
jsonFile.close()

