from typing import Dict, Iterable, List, KeysView, ItemsView, ValuesView

import matplotlib.pyplot as plt
import pandas as pd
import requests


class Pokemon:
    def __init__(self, name: str = None, number: int = None) -> None:
        if name and number:
            self.name = name
            self.number = number
            self.url = "https://pokeapi.co/api/v2/pokemon/" + name
        elif name:
            self.name = name
            self.url = "https://pokeapi.co/api/v2/pokemon/" + name
            self.number = requests.get(self.url).json()["id"]
        elif number:
            self.number = number
            self.url = "https://pokeapi.co/api/v2/pokemon/" + str(number)
            self.name = requests.get(self.url).json()["name"]
            self.url = "https://pokeapi.co/api/v2/pokemon/" + self.name
        elif name is None and number is None:
            raise TypeError("You must provide either a name or a number!")
        elif name == "":
            raise ValueError("Name cannot be an empty string.")
        elif number == 0:
            raise ValueError("Number cannot be zero.")

    @property
    def keys(self) -> KeysView:
        return requests.get(self.url).json().keys()

    @property
    def values(self) -> ValuesView:
        return requests.get(self.url).json().values()

    @property
    def items(self) -> ItemsView:
        return requests.get(self.url).json().items()

    @property
    def abilities(self) -> List:
        return requests.get(self.url).json()["abilities"]

    @property
    def ability_names(self) -> List:
        return [
            d["ability"]["name"] for d in requests.get(self.url).json()["abilities"]
        ]

    @property
    def base_experience(self) -> int:
        return requests.get(self.url).json()["base_experience"]

    @property
    def forms(self) -> List:
        return requests.get(self.url).json()["forms"]

    @property
    def game_indices(self) -> List:
        return requests.get(self.url).json()["game_indices"]

    @property
    def held_items(self) -> List:
        return requests.get(self.url).json()["held_items"]

    @property
    def height(self) -> int:
        return requests.get(self.url).json()["height"]

    @property
    def id(self) -> int:
        return requests.get(self.url).json()["id"]

    @property
    def is_default(self) -> bool:
        return requests.get(self.url).json()["is_default"]

    @property
    def location_area_encounters(self) -> str:
        return requests.get(self.url).json()["location_area_encounters"]

    @property
    def moves(self) -> List:
        return requests.get(self.url).json()["moves"]

    # Move related methods
    def get_move_by_number(self, number: str) -> Dict:
        return requests.get(
            self.url
                .replace("pokemon", "move")
                .replace(self.name, str(number))
        ).json()

    def get_move_names(self, numbers: Iterable) -> List:
        return [
            move["name"] for move
            in [self.get_move_by_number(n) for n in numbers]
        ]

    def get_move_by_name(self, name: str) -> Dict:
        return {
            d["move"]["name"]: d["move"]
            for d in requests.get(self.url).json()["moves"]
        }[name]

    def plot_move_powers(
            self,
            numbers: Iterable,
            ascending: bool = True
    ) -> None:
        pd.DataFrame({
            move["name"]: move["power"] for move
            in [self.get_move_by_number(n) for n in numbers]
        },
            index=[self.name]
        ).melt(
            var_name="move",
            value_name="power"
        ).sort_values(
            by="power",
            ascending=ascending
        ).set_index("move").plot.barh(legend=False)
        plt.suptitle(f"Power values for {self.name}")
        plt.title(f"Obtained from {self.url}")
        plt.show()

    @property
    def order(self) -> int:
        return requests.get(self.url).json()["order"]

    @property
    def species(self) -> Dict:
        return requests.get(self.url).json()["species"]

    @property
    def sprites(self) -> Dict:
        return requests.get(self.url).json()["sprites"]

    @property
    def sprite_options(self) -> KeysView:
        return requests.get(self.url).json()["sprites"].keys()

    @property
    def stats(self) -> List:
        return requests.get(self.url).json()["stats"]

    @property
    def types(self) -> List:
        return requests.get(self.url).json()["types"]

    @property
    def weight(self) -> int:
        return requests.get(self.url).json()["weight"]

    def get_ability(self, name: str) -> Dict:
        return {
            d["ability"]["name"]: d["ability"]
            for d in requests.get(self.url).json()["abilities"]
        }[name]

    def show_sprite(self, option: str = "front_default") -> None:
        plt.imshow(plt.imread(requests.get(self.url).json()["sprites"][option]))


def main():
    p = Pokemon(number=7)
    print(f"Pokemon: {p.weight}")
    print(f"Name: {p.name}")
    # f"Moves: {p.get_move_by_number(p.moves)}"
    stats = p.stats
    stat_list = {}
    for item in stats:
        # print(item)
        stat = item['stat']
        name = stat['name']
        val = stat['base_stat']

        stat_val = {
            'name': name,
            'base_stat': val
        }

        stat_list[item] = stat_val

    print(stat_list)
    # print(moves)


def get_all_items(d_items):
    for key, value in d_items.items():
        if type(value) is dict:
            get_all_items(value)
        else:
            print(f"{key}, {value}")


def get_power(d_items):
    for key in d_items.items():
        if key == "power":
            for item in key:
                print(item)




if __name__ == '__main__':
    main()
