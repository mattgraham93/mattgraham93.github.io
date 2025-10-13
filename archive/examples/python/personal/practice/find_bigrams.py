sentence = """Nory was a Catholic because her mother was a Catholic, and Nory’s mother was a Catholic because her 
father was a Catholic, and her father was a Catholic because his mother was a Catholic, or had been. """

words = sentence.split()
bi_grams = []

for i in range(len(words)-1):
    # print(i)  # debugging
    pair = (words[i], words[i+1])
    bi_grams.append(pair)

print("---- Pairs ----")

for pair in bi_grams:
    print(pair)
