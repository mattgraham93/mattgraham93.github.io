with open('LLCP2017.ASC') as f:
    # counter = 0
    # h = open('data-split-test1.csv', 'w')
    # j = open('data-split-test2.csv', 'w')
    file = open('../../data/test.csv', 'w')
    num = 0
    while num < 10:
        index = 0
        line = f.readline()
        length = len(line)
        print(length)
        num += 1

        while index < length:
            if index < length - 1:
                file.write(line[index] + ',')
                index += 1
            elif index == length - 1:
                file.write(line[index])
                index += 1
            else:
                print('error')

    # while True:
    #     line = f.readline()
    #     index = 0
    #     num = len(line)
    #
    #     while index < num:
    #         if index < (num / 2) - 1:
    #             h.write(line[index] + ',')
    #             index += 1
    #         elif index == (num / 2) - 1:
    #             h.write(line[index] + '\n')
    #             index += 1
    #         elif index > (num / 2) - 1:
    #             j.write(line[index] + ',')
    #             index += 1
    #         elif index == num - 1:
    #             j.write(line[index] + '\n')
    #         else:
    #             print("error")
    #
    #     counter += 1
    #
    #     if not line:
    #         print("All lines processed")
    #         break
    #     pass
    #
    # print("Total lines: " + str(counter))
