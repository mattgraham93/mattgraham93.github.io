def get_first_recur_letter(word):
    # print(word[0] == val)
    count = {}
    for c in word:
        if c in count:
            count[c] += 1
            return c
        else:
            count[c] = 1


def main():
    # print("get started")
    word = "anotherone"
    print(f"First recurring letter: {get_first_recur_letter(word)}")


if __name__ == "__main__":
    main()
