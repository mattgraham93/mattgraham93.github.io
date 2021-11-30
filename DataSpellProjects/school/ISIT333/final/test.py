import random


def main():
    nums = [random.randint(1000, 9999)]

    for i in range(15):
        num = check_rand(random.randint(1000, 9999), nums)
        nums.append(num)

    print(nums)


def check_rand(rand_int, nums):
    for num in nums:
        if num == rand_int:
            check_rand(rand_int=random.randint(1000, 9999))
        else:
            return rand_int


if __name__ == "__main__":
    main()