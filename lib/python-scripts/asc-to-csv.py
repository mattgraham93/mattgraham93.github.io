with open('LLCP2017.ASC') as f:
    counter = 0
    h = open('data-split-test1.csv', 'w')
    j = open('data-split-test2.csv', 'w')

    while True:
        line = f.readline()
        index = 0
        num = len(line)

        while index < num:
            if index < (num / 2) - 1:
                h.write(line[index] + ',')
                index += 1
            elif index == (num / 2) - 1:
                h.write(line[index] + '\n')
                index += 1
            elif index > (num / 2) - 1:
                j.write(line[index] + ',')
                index += 1
            elif index == num - 1:
                j.write(line[index] + '\n')
            else:
                print "error"

        counter += 1

        if not line:
            print "All lines processed"
            break
        pass

    print "Total lines: " + str(counter)
