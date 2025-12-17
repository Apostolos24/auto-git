# auto-git
A small bash/batch script to pull and push from a local repo to github and reverse.

# Setup
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
```./auto_ssh [-m <commit_message>] [-f] [-h]```

### Basic Use
The script first pulls all changes from the **main** branch on the remote github repo. Then it adds+commits the changes to your local repo with a commit message: 
"Auto-sync: {date}". Finally it pushes the commited changes to the remote github repo, but will fail if there are confilcts.

### Flags
Flags are optional and provide extra functionality.

  ```-m```  : Specify a custom commit message
  
  ```-f```  : Force push (use with caution!)
  
  ```-h```  : Show this help message
