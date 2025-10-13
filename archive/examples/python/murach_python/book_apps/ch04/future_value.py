import nameformat as myNames

def sayHello(first_name):
    print("Hello %s!" % first_name)


def fullName(first_name, last_name):
    print(first_name, last_name)


def lastNameFirst(first_name, last_name):
    print("%s, %s" % last_name, first_name)


def main():
    name = input("Hi! What is your name?\n")
    name_split = name.split(' ')
    first_name = name_split[0]
    last_name = name_split[1]

    sayHello(first_name)
    fullName(first_name, last_name)
    lastNameFirst(first_name, last_name)

    print("Bye!")


if __name__ == "__main__":
    main()
