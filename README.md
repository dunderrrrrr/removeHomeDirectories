# removeHomeDirectories.ps1

This script removes **inactive** users homefolders from a share within a specific OU.  
Change `$oupath` to fit your needs. Apply `-force` to run script without asking for user input.

```
PS> .\removeHomeDirectories.ps1
##### SCRIPT START ####
Friday 02/07/2021 05:59:13

Homedirs found:

HomeDirectory                                                        samAccountName                                                     
-------------                                                        --------------                                                     
\\localhost\homefolders\user1                                        user1                                                              
\\localhost\homefolders\user2                                        user2                                                              
\\localhost\homefolders\user3                                        user3                                                              
                                                                     user4                                                              

Remove paths? (y/n): y
Removing: \\localhost\homefolders\user1 (user1)
Removing: \\localhost\homefolders\user2 (user2)
Info: Path \\localhost\homefolders\user3 does not exist (user3)
Skipping: user4 is missing homefolder.

Friday 02/07/2021 05:59:14
#### SCRIPT END ####
```