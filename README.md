<div align="center">

🚀 **S&P 500 Companies Timeline Sorter**

*A lightweight Bash utility that downloads the latest S&P 500 company dataset from GitHub and generates a chronologically sorted list by founding year.*

![Bash](https://img.shields.io/badge/Bash-Shell_Script-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Compatible-blue?style=for-the-badge&logo=linux)
![CSV](https://img.shields.io/badge/Output-CSV-orange?style=for-the-badge)

</div>

---

📌 **Overview**

This project automatically downloads the latest S&P 500 constituent dataset, extracts important company information, sorts all companies by founding year, and exports the result into a clean CSV file.

Perfect for learning Bash scripting, CSV processing, automation, and command-line data manipulation.

---

✨ **Features**

✅ Downloads live data directly from GitHub

✅ Automatically processes CSV files

✅ Sorts companies from oldest to newest

✅ Generates a clean output CSV

✅ Displays a quick terminal summary

✅ Lightweight and fast

✅ Works on Linux and macOS

---

📂 **Generated Output**

```
sp500_companies_sorted_by_year.csv
```

Columns included:

• Company Name

• Headquarters Location

• Founded Year

• Stock Symbol

• GICS Sector

---

🖥 **Terminal Preview**

```text
=============================================
        S&P 500 Companies Timeline
=============================================

Downloading latest dataset...

Processing records...

✔ Total Companies : 503
✔ Valid Years     : 482

Top 15 Oldest Companies
------------------------
...
...

Top 15 Newest Companies
------------------------
...
...

CSV generated successfully.
```

---

⚙️ **Requirements**

```
bash
curl
awk
sort
```

These utilities are available by default on most Linux distributions.

---

🚀 **Usage**

```bash
git clone https://github.com/debjit604/Shell-Script-S-P-500-Companies.git

cd Shell-Script-S-P-500-Companies

chmod +x sp500_sort.sh

./sp500_sort.sh
```

---

📁 **Project Structure**

```text
Shell-Script-S-P-500-Companies/
│
├── sp500_sort.sh
├── README.md
└── sp500_companies_sorted_by_year.csv
```

---

🛠 **Built With**

• Bash

• curl

• awk

• sort

• Unix Text Processing Utilities

---

🎯 **What This Project Demonstrates**

✔ Shell Scripting

✔ Automation

✔ CSV Parsing

✔ Linux Command Line

✔ Data Processing

✔ Sorting Algorithms

✔ GitHub Project Organization

---

🚀 **Future Enhancements**

• JSON Export

• Interactive Search

• Sector Filtering

• Company Age Calculator

• Statistics Dashboard

• Docker Support

---

👨‍💻 **Author**

**Debjit**

GitHub:

https://github.com/debjit604

---

⭐ **Repository**

https://github.com/debjit604/Shell-Script-S-P-500-Companies

---

*"Small scripts. Powerful automation."*
