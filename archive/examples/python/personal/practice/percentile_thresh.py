import numpy as np
import scipy.stats as st


def truncated_dist(m, sd, n, percentile_threshold):
    lim = st.norm(m, sd).ppf(percentile_threshold)
    v = [0] * n
    i = 0
    while i < n:
        r = np.random.normal(m, sd, 1)[0]
        if r <= lim:
            v[i] = r
            i = i + 1

    return (v)


def main():
    n = 6
    sd = 1
    m = 2
    thresh = 0.75

    vals = truncated_dist(m, sd, n, thresh)
    print(f"Values below {thresh} percentile")
    for val in vals:
        print(round(val, 2))


if __name__ == "__main__":
    main()
