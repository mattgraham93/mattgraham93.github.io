import queue

q = queue.Queue()

for i in range(15):
    q.put(i)

print("Member queue: ")
for member in q.queue:
    print(member, end=" ")

print()
print(f"Total members: \n{q.qsize()}")
