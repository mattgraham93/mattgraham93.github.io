import bisect


def index(a, x):
    # 'Locate the leftmost value exactly equal to x'
    i = bisect.bisect_left(a, x)
    if i != len(a) and a[i] == x:
        return i
    raise ValueError


def find_lt(a, x):
    # 'Find rightmost value less than x'
    i = bisect.bisect_left(a, x)
    if i:
        return a[i - 1]
    raise ValueError


def find_le(a, x):
    # 'Find rightmost value less than or equal to x'
    i = bisect.bisect_right(a, x)
    if i:
        return a[i - 1]
    raise ValueError


def find_gt(a, x):
    # 'Find leftmost value greater than x'
    i = bisect.bisect_right(a, x)
    if i != len(a):
        return a[i]
    raise ValueError


def find_ge(a, x):
    # 'Find leftmost item greater than or equal to x'
    i = bisect.bisect_left(a, x)
    if i != len(a):
        return a[i]
    raise ValueError


def main():
    a = [1, 2, 4, 5, 2, 1]
    print(index(a, 4))
    print(find_lt(a, 2))
    print(find_le(a, 3))
    print(find_gt(a, 3))
    print(find_ge(a, 5))


if __name__ == "__main__":
    main()
