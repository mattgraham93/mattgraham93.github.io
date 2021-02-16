with open('LLCP2017.ASC', 'r') as f:
    # g = open('test.csv', 'w')
    # g.write(f.readline())

    line = f.readline()
    num = len(line)
    print(num)
    cs = ",".join(line)
    # index = 0
    # length = num
    #
    # while index < length:
    #     if index < length:
    #         cs += line[index] + ','
    #         index += 1
    #     elif index == length - 1:
    #         cs +=
    #     else:
    #         print('error')

    # print('CS line: ' + cs)
    index = 0
    # print(cs[index])

    arr = []

    for c in cs:
        if c != ",":
            arr.append(c)

    # print(arr)

    info = {}

    for ch in arr:
        ch = arr[index(ch)]
        if ch.isnumeric():
            info.update({arr.index(ch): ch})

    print(info)
