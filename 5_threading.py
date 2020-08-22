import threading
import requests

def f(text,n):
    print(text[n])


if __name__ == "__main__":
    threads=[]
    text = requests.get('https://github.com/okids/practice').text
    for c in range(1,5000):
        t = threading.Thread(target=f,args=(text,c,))
        threads.append(t)
        t.start()
    x=input("Press any key to exit")
