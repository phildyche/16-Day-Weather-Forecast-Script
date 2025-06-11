Creating a GitHub Repository

Via GitHub Web UI

Log in to GitHub and click the + icon ▶️ New repository.

Repository name: weather-forecast-16day

Description: "R script for 16-day weather forecasts using Open-Meteo API"

Public or Private: choose based on preference.

Check Add a README file and Add .gitignore (select R).

Click Create repository.

Pushing Local Code via CLI

If you started locally:

git init
git add .
git commit -m "Initial commit: add forecast script and docs"
git branch -M main
git remote add origin https://github.com/<your-username>/weather-forecast-16day.git
git push -u origin main

Managing Repository

Issues: Enable issues in Settings ▶️ Issues.

Pull Requests: Add templates in .github/ISSUE_TEMPLATE and .github/PULL_REQUEST_TEMPLATE.

Actions: Optionally set up CI to test the script.
