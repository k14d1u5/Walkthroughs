import base64

encpassword = "0Nv32PTwgYjzg9/8j5TbmvPd3e7WhtWWyuPsyO76/Y+U193E"
key = b"armando"

# Decodifica Base64
array = base64.b64decode(encpassword)

# Applica XOR per ogni byte
array2 = bytearray()
for i in range(len(array)):
    array2.append(array[i] ^ key[i % len(key)] ^ 0xDF)

# Restituisce la stringa decodificata
result = array2.decode("latin1")  # latin1 per compatibilità con Encoding.Default di C#

print(result)
