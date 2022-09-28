import pylast


def main():
    api_key = "0aa2d7f7c74e7306cb31fa304c579646"
    shared_secret = "db255ba49c3a91726a0b567d23d1f6ad"
    username = "bravade_"
    password_hash = pylast.md5("Br@vo423")

    network = pylast.LastFMNetwork(
        api_key=api_key,
        api_secret=shared_secret,
        username=username,
        password_hash=password_hash,
    )

    track = network.search_for_album("In Loving Memory")
    print(track.get_wiki())


if __name__ == '__main__':
    main()