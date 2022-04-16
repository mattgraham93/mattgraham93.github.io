def replace_words(roots, sentence):
    words = sentence.split()
    for word in words:
        # print(word)
        for root in roots:
            # print(root)
            if word.startswith(root):
                sentence = sentence.replace(word, root)
                print("word replaced")

    print(sentence)


def main():
    roots = ["cat", "bat", "rat"]
    sentence = "the cattle was rattled by the battery"
    replace_words(roots, sentence)


if __name__ == "__main__":
    main()
