import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AccessFile{
  static Map<dynamic,dynamic> map;

  static String defaultContent = '{\r\n  \"training\": [\r\n    {\r\n      \"title\": \"Treino Padr\u00E3o\",\r\n      \"desc\": \"Treino moderado para defini\u00E7\u00E3o muscular\",\r\n      \"modules\": [\r\n        {\r\n          \"title\": \"Modulo A\",\r\n          \"desc\": \"MMI e Ombro\",\r\n          \"exercises\": [\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Corrida\",\r\n              \"settings\": [\r\n                1,\r\n                0.10\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Agac. Sum\u00F4\",\r\n              \"settings\": [\r\n                3,\r\n                0.22\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Agac. Stiff\",\r\n              \"settings\": [\r\n                3,\r\n                0.22\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Afundo\",\r\n              \"settings\": [\r\n                3,\r\n                0.22\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Avan\u00E7o\",\r\n              \"settings\": [\r\n                3,\r\n                0.22\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Agac. na parede\",\r\n              \"settings\": [\r\n                3,\r\n                0.22\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Coice para gluteos\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Flex\u00E3o de posterior\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Panturrilha em p\u00E9\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Des. em p\u00E9\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Elev. lateral\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Elev. frontal\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"ABS supra\",\r\n              \"settings\": [\r\n                3,\r\n                0.16\r\n              ]\r\n            }\r\n          ]\r\n        },\r\n        {\r\n          \"title\": \"Modulo B\",\r\n          \"desc\": \"Costa e B\u00EDceps\",\r\n          \"exercises\": [\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Pular corda\",\r\n              \"settings\": [\r\n                3,\r\n                0.16\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Remada sup.\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Pull over\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Remada\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Rosca dir.\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Rosca inversa\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Rosca unil.\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Rosca alter.\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Rosca martelo\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"ABS remador\",\r\n              \"settings\": [\r\n                3,\r\n                0.16\r\n              ]\r\n            }\r\n          ]\r\n        },\r\n        {\r\n          \"title\": \"Modulo C\",\r\n          \"desc\": \"Peito e Tr\u00EDceps\",\r\n          \"exercises\": [\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Polichinelo\",\r\n              \"settings\": [\r\n                3,\r\n                0.22\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Flex\u00E3o\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Voador unil.\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Crucifixo unil.\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Tr\u00EDceps testa\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Tr\u00EDceps franc\u00EAs\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Tr\u00EDceps afun.\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            },\r\n            {\r\n              \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n              \"title\": \"Prancha\",\r\n              \"settings\": [\r\n                3,\r\n                0\r\n              ]\r\n            }\r\n          ]\r\n        }\r\n      ]\r\n    }\r\n  ],\r\n  \"challenge\": [\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"1000 Flex\u00F5es\",\r\n      \"desc\": \"Fa\u00E7a 100 flex\u00F5es por dia no decorrer de 10 dias\",\r\n      \"done\": \"Parab\u00E9ns! Voc\u00EA realizou as 1000 flex\u00F5es em 10 dias!\",\r\n      \"isIn\": false,\r\n      \"lastDay\": \"\",\r\n      \"result\": \"win\",\r\n      \"amountDay\": 0,\r\n      \"amountTotal\": 10\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"1000 Abdominais\",\r\n      \"desc\": \"Fa\u00E7a 100 abdominais por dia no decorrer de 10 dias\",\r\n      \"done\": \"Parab\u00E9ns! Voc\u00EA realizou as 1000 abdominais em 10 dias!\",\r\n      \"isIn\": false,\r\n      \"lastDay\": \"\",\r\n      \"result\": \"win\",\r\n      \"amountDay\": 0,\r\n      \"amountTotal\": 10\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"5000 Polichinelos\",\r\n      \"desc\": \"Fa\u00E7a 500 polichinelos por dia no decorrer de 10 dias\",\r\n      \"done\": \"Parab\u00E9ns! Voc\u00EA realizou as 5000 polichinelos em 10 dias!\",\r\n      \"isIn\": false,\r\n      \"lastDay\": \"\",\r\n      \"result\": \"win\",\r\n      \"amountDay\": 0,\r\n      \"amountTotal\": 10\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"100 KM\",\r\n      \"desc\": \"Corra 10 km por dia em 10 dias\",\r\n      \"done\": \"Parab\u00E9ns! Voc\u00EA correu 100 km em 10 dias!\",\r\n      \"isIn\": false,\r\n      \"lastDay\": \"\",\r\n      \"result\": \"win\",\r\n      \"amountDay\": 0,\r\n      \"amountTotal\": 10\r\n    }\r\n  ],\r\n  \"exercises\": [\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Corrida\",\r\n      \"settings\": [\r\n        1,\r\n        0.10\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Agac. Sum\u00F4\",\r\n      \"settings\": [\r\n        3,\r\n        0.22\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Agac. Stiff\",\r\n      \"settings\": [\r\n        3,\r\n        0.22\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Afundo\",\r\n      \"settings\": [\r\n        3,\r\n        0.22\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Avan\u00E7o\",\r\n      \"settings\": [\r\n        3,\r\n        0.22\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Agac. na parede\",\r\n      \"settings\": [\r\n        3,\r\n        0.22\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Coice para gluteos\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Flex\u00E3o de posterior\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Panturrilha em p\u00E9\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Des. em p\u00E9\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Elev. lateral\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Elev. frontal\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"ABS supra\",\r\n      \"settings\": [\r\n        3,\r\n        0.16\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Pular corda\",\r\n      \"settings\": [\r\n        3,\r\n        0.16\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Remada sup.\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Pull over\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Remada\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Rosca dir.\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Rosca inversa\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Rosca unil.\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Rosca alter.\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Rosca martelo\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"ABS remador\",\r\n      \"settings\": [\r\n        3,\r\n        0.16\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Polichinelo\",\r\n      \"settings\": [\r\n        3,\r\n        0.22\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Flex\u00E3o\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Voador unil.\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Crucifixo unil.\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Tr\u00EDceps testa\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Tr\u00EDceps franc\u00EAs\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Tr\u00EDceps afun.\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    },\r\n    {\r\n      \"link\": \"https:\/\/flutter.github.io\/assets-for-api-docs\/assets\/videos\/butterfly.mp4\",\r\n      \"title\": \"Prancha\",\r\n      \"settings\": [\r\n        3,\r\n        0\r\n      ]\r\n    }\r\n  ],\r\n  \"profile\": {\r\n    \"name\": \"\",\r\n    \"trainingDays\": 0,\r\n    \"fullChallenge\": 0,\r\n    \"calories\": 0,\r\n    \"lastDayTraining\": \"\"\r\n  },\r\n  \"read\": false\r\n}\r\n';

  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/fileFull.json");
  }



  static Future<File> saveData() async {
    map['read']=true;
    String data = json.encode(map);
    final file = await getFile();
    return file.writeAsString(data);
  }

  static Future<String> readData() async {
    try {
      final file = await getFile();
      if (FileSystemEntity.typeSync(file.path) !=
          FileSystemEntityType.notFound) {
        return file.readAsString();
      } else {
        map = json.decode(defaultContent);
        saveData();
      }
    } catch (e) {
      return null;
    }
  }
}