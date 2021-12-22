import datetime
from datetime import datetime

# ts = [] #convert to datetime for testing
# for t in ts:
#     nts.append(datetime.strptime(t, '%Y-%m-%d'))


def weekly_aggregation(ts, delim='-'):
    # Groups an ordered list of timestamps as strings by week.
    # The first day of the first week is defined by the earliest timestamp.
    # Dates should be ordered by year, month and day
    #
    # Parameters:
    # ts: str, list of timestamps
    # delim: str, delimeter that separates the date
    out, week, week_ind = [], [], 0
    for i,t in enumerate(ts):
        if i == 0:
            week.append(t)
            start_date = datetime.strptime(t, f'%Y{delim}%m{delim}%d')
            continue
        t_date = datetime.strptime(t, f'%Y{delim}%m{delim}%d')
        n = (t_date - start_date).days // 7
        if n == week_ind:
            week.append(t)
        elif n > week_ind:
            week_ind = n
            out.append(week)
            week = []
            week.append(t)

        # error raising
        else:
            print('Dates do not appear to be in order.')
            return 0

    # Make sure we don't miss out last week
    if len(week) > 0:
        out.append(week)

    return out


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

    print(weekly_aggregation(ts))


if __name__ == "__main__":
    main()