# Univerank - Get All University Rankings!
A Shiny app which allows the stakeholders(students) to conduct proper research on tertiary institutions before making a finalised decision on their future place of study

Link to Rpubs : https://rpubs.com/ahsan0102/917744

Link to Shiny app : https://um-samweihong.shinyapps.io/univerank/

## Data Science Processes
### Asking Questions
- What is the change in ranking of a university over a range of years?

- Why does a university have a higher ranking than other universities?

- What are the rankings of a university based on different systems?

- What are the global and national ranking of a university?

### Finding data
We find datasets on public data platforms such as Kaggle and well-known university ranking websites.

### Getting data
We retrieve data from Times Higher Education, QS World University Rankings and Kaggle datasets.

### Cleaning data
We remove duplicate data and correct inconsistent data to produce a clean data.

### Analysing data
We perform exploratory data analysis (EDA) by converting raw data into meaningful plots.

### Presenting data
We deploy and demonstrate our data product on the shiny server.

## Dataset descriptions
We obtain our datasets mainly from the two major ranking systems, which are **Times Higher Education** and **QS World University Rankings** websites. You can find both of them in the csv format in the `data` directory at our GitHub repository. They consist of the university names, their rankings, overall scores and other metrics in determining the scores in the respective years.

Some of the dataset features include:

- **Rank** - University ranking 

- **Name** - Name of institution

- **Year** - Year of rankings

- **Location** - Location of institution

- **Overall scores** - Overall scores of five performance indicators

- **Teaching scores**
    - Reputation Survey - Teaching
    - Academic Staff-to-Student Ratio
    - Doctorates Awarded / Undergraduate Degrees Awarded
    - Institutional Income / Academic Staff

- **Citation scores** - Field Weighted Citation Impact

- **Research scores**
    - Reputation Survey – Research
    - Research Income / Academic Staff
    - Publications / Staff (Academic Staff + Research Staff)

- **Industry income**
    - Proportion of International Students
    - Proportion of International Academic Staff
    - International co-authorship (International Publications / Publications Total)

- **International outlook** - Research income from industry & commerce / Academic Staff

## Documentation
This manual is structured to ensure that users have a complete idea using our application. It can be also found in the application.

### Ranking Comparison
In this section, users can compare the change of a university's rankings from 2017 to 2021.
1. Select a ranking system of QS or THE. If both are chosen, then only Malaysia universities will be available.
2. Select an university present in the chosen ranking system(s).

![Ranking Comparison](https://github.com/umSamWeiHong/Univerank/blob/master/img/ranking_comparison.PNG)

### Metric Comparison
In this section, users can compare the change of a university's metric scores from 2017 to 2021.
1. Select a ranking system of either QS or THE.
2. Select an university present in the chosen ranking system.
3. Select the metric(s) to be displayed on the plot.

![Metric Comparison](https://github.com/umSamWeiHong/Univerank/blob/master/img/metric_comparison.PNG)

### University Comparison
In this section, users can compare three different universities' metric scores in a specified year.
1. Select a ranking system of either QS or THE.
2. Select three different universities present in the chosen ranking system.
3. Choose a year where the scores are taken.
4. Select the metric(s) to be displayed on the plot.

![University Comparison](https://github.com/umSamWeiHong/Univerank/blob/master/img/university_comparison.PNG)

### Country Comparison
In this section, users can compare the ranking or overall scores of top n universies in a specified country and year.
1. Select a ranking system of either QS or THE.
2. Select a country present in the chosen ranking system.
3. Choose a year where the rankings are taken.
4. Select the range of n, that is the top n universities to be shown.
5. Select whether to display the ranking or overall scores on the plot.

![Country Comparison Ranking](https://github.com/umSamWeiHong/Univerank/blob/master/img/country_comparison_ranking.PNG)

![Country Comparison Scores](https://github.com/umSamWeiHong/Univerank/blob/master/img/country_comparison_scores.PNG)
