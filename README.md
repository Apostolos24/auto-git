# auto-git
A small bash/batch script to pull and push *fast*  from a local repo to github and reverse.

# Motivation 
I have a folder in my PC that inside has files from my undergraduate cource, my projects and many more. This folder contains most of the stuff I need to work on a daily basis and I keep it organised to find everything easily. When I had only my PC that was easy since everything was in one place, but then I also got a laptop to be able to carry to the university. That meant that I had to move all the files from my PC to the laptop but most importantly keep it synchronised. When I worked on something the night before on my PC then went the next day in class, I wanted to be able to continue whatever I was doing last night, on my Laptop, which sometimes meant 10s or 100s of files and the same held true when I got home that day and wanted to continue on my PC whatever I had done with my Laptop. I quickly set up a private repository in github to store everything on that folder, in order to access everything easily. All I had to do was pull when I logged on and push when I logged off. Easy? Well, it turns out that I forgot... a lot. I would make a *small* change on one computer and forget to commit+push (or maybe I was bored) and realise that (to my horror) the next day, that the change I needed for me to continue was not there. So I needed something that was fast (I didn't wast to have to pull+add+commit+push each time I wanted to make a change) and easy as to not forget or put it off (I am lazy I know, but *Laziness in the mother of invention*). With auto_git I just have a shortcut on my desktop and double-click when I turn on my computer and also when I turn it off so its easy.  

# Setup
### Download the script
**Linux:** Download **auto_git.sh** in your prefered directory and run ```chmod +x auto_git.sh```. For easier use you can add auto_git.sh to your $PATH so you can call it directly from anywhere.

**MAC:** Download **auto_git.command** in your prefered directory and run ```chmod +x auto_git.command```.

**Windows:** Download **auto_git.bat** in your prefered folder.
<br>
<br>

### Configure git name and email
```git config --global user.name "your_name"```

```git config --global user.email "your_email@example.com"```
<br>
<br>

### If you already have started your project inside a folder initialize an empty local repo and sync it with a remote github repo: 
```git init```

```git remote add [your-repo.git]```

```git push -u origin <main_branch_name>```
<br>
<br>
    
### If you want to use an existing github repo to initialize you local git repo:
```git clone [your-repo.git]```
<br>
<br>

# How to use
### Running the Script
**Terminal** 

```Linux: ./auto_git.sh [-m <commit_message>] [-f] [-h]```

```MAC: ./auto_git.sh [-m <commit_message>] [-f] [-h]```

```Windows: ./auto_git.bat [-m <commit_message>] [-f] [-h]```

**GUI**

Linux/MAC/Windows: You can simply double-click on the script's icon and it will open a terminal, run the script without flags and close the terminal when it is done.
<br>
<br>

### Basic Use
The script first pulls all changes from the **main** branch on the remote github repo. Then it adds+commits the changes to your local repo with a commit message: 
"Auto-sync: {date}". Finally it pushes the commited changes to the remote github repo, but will fail if there are confilcts.
<br>
<br>

### Flags
Flags are optional and provide extra functionality.

  ```-m```  : Specify a custom commit message
  
  ```-f```  : Force push (use with caution!)
  
  ```-h```  : Show help message
