# Function to find all unique combination of
# given elements such that their sum is K

def sum_to_n(integers, target):
    # create empty list
    output = []
    # check for end of list
    if target < 0:
        return []
    # iterate through list of numbers
    for i in range(len(integers)):
        # check if the passed value is the sum of the target
        if target == integers[i]:
            output.append([integers[i]])
        else:
            # get the next remaining values without the selected integer
            # pass the next integer of the list to identify as a target to sum
            for j in sum_to_n(integers[i:], target-integers[i]):
                # append items where remaining items and selected value are the sum of target
                output.append([integers[i]]+j)
    return output


def main():
    nums = [2, 3, 5]
    target = 8
    combos = sum_to_n(nums, target)
    print(combos)


if __name__ == "__main__":
    main()
