#!/usr/bin/env python3

def move_disk(n, src, dest, temp):
    if n == 0:
        return
    else:
        move_disk(n-1, src, temp, dest)
        print("Move disk", n, "from", src, "to", dest)
        move_disk(n-1, temp, dest, src)
        
def main():
    print("**** TOWERS OF HANOI ****")
    print()
    num_disks = int(input("Enter number of disks: "))
    print()
    
    move_disk(num_disks, "A", "C", "B")

    print()
    print("All disks have been moved.")

if __name__ == "__main__":
    main()
