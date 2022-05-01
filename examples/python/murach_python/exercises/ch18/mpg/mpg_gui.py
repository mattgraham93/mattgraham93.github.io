#!/usr/bin/env python3

import tkinter as tk
from tkinter import ttk

class MyFrame(ttk.Frame):
    def __init__(self, parent):
        ttk.Frame.__init__(self, parent, padding="10 10 10 10")
        self.pack()

        # Define string variables for text entry fields
        self.test = tk.StringVar()

        # Display the grid of components
        ttk.Label(self, text="Label 1:").grid(
            column=0, row=0, sticky=tk.E)
        ttk.Entry(self, width=30, textvariable=self.test).grid(
            column=1, row=0)

        # Add padding to all components
        for child in self.winfo_children():
            child.grid_configure(padx=5, pady=3)

if __name__ == "__main__":
    root = tk.Tk()
    root.title("Program Title")
    MyFrame(root)
    root.mainloop()
