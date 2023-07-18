def getNestedValue(obj, key):
    keys = key.split('/')
    value = obj

    for k in keys:
        value = value[k]
    return value

#User input
obj_input = input("Enter the object : ")
key_input = input("Enter the key or keys : ")

obj_dict = eval(obj_input)

outputValue = getNestedValue(obj_dict , key_input)

print("Output Value : " , outputValue)
