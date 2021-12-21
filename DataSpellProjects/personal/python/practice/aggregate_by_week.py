import pandas as pd



def weekly_aggregate(ts):
    df = pd.to_datetime(ts)

    df.groupby()


def main():
    ts = [
        '2020-01-01',
        '2020-01-02',
        '2020-01-04',
        '2020-01-08',
        '2020-02-13',
        '2020-02-14',
        '2020-02-19',
    ]

    weekly_aggregate(ts)

if __name__ == "__main__":
    main()