f = open('test.csv', 'r+')
columns = ''

while True:
    line = f.readline()
    print(line)
    index = 0
    c = line[index]
    num = int(c)

    if num > 0:
        if index < len(line):
            columns += str(index) + ','
            index += 1
            print("Total characters" + str(index))
        elif index == len(line):
            columns += str(index) + '\n'
        else:
            print('error')

    if not line:
        print("Below are your columns:")
        break
    pass

print("columns: " + str(columns))
