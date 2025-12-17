# auto-git
A small bash/batch script to pull and push from a local repo to github and reverse.

# Setup
### Configure git name and email
```git config --global user.name "your_name"```

```git config --global user.email "your_email@example.com"```
<br>

### If you already have started your project inside a folder initialize an empty local repo and sync it with a remote github repo: 
```git init```

```git remote add [your-repo.git]```

```git push -u origin <main_branch_name>```  
<br>
    
### If you want to use an existing github repo to initialize you local git repo:
```git clone [your-repo.git]```

# How to use
