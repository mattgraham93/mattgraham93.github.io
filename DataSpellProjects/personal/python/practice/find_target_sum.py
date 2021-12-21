# Function to find all unique combination of
# given elements such that their sum is K


def unique_combination(l, sum, k, local, a):

    # If a unique combination is found
    if sum == k:
        print("{", end="")
        for i in range(len(local)):
            if i != 0:
                print(" ", end="")
            print(local[i], end="")
            if i != len(local) - 1:
                print(", ", end="")
        print("}")
        return

    # For all other combinations
    for i in range(l, len(a), 1):

        # Check if the sum exceeds K
        if sum + a[i] > k:
            continue

        # Check if it is repeated or not
        if (i > l and
                a[i] == a[i - 1]):
            continue

        # Take the element into the combination
        local.append(a[i])

        # Recursive call
        unique_combination(i + 1, sum + a[i],
                           k, local, a)

        # Remove element from the combination
        local.remove(local[len(local) - 1])


# Function to find all combination of the given elements
def combination(a, k):
    # Sort the given elements
    a.sort(reverse=False)
    local = []
    unique_combination(0, 0, k, local, a)


def main():
    nums = [2, 3, 5]
    target = 8
    combination(nums, target)


if __name__ == "__main__":
    main()
