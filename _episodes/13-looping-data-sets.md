---
title: "Looping Over Data Sets"
teaching: 5
exercises: 10
questions:
- "How can I process many data sets with a single command?"
objectives:
- "Be able to read and write globbing expressions that match sets of files."
- "Use glob to create lists of files."
- "Write for loops to perform operations on files given their names in a list."
keypoints:
- "Use a `for` loop to process files given a list of their names."
- "Use `glob.glob` to find sets of files whose names match a pattern."
- "Use `glob` and `for` to process batches of files."
---

## Use a `for` loop to process files given a list of their names.

*   A filename is just a character string.
*   And lists can contain character strings.

~~~
import pandas

for filename in ['data/jarvis_all.csv', 'data/jarvis_subset.csv']:
    data = pandas.read_csv(filename, index_col='formula')
    print(filename, data.min())
~~~
{: .python}
~~~
data/jarvis_all.csv epsx             1.0681
epsy             1.0681
epsz             1.0681
fin_en         -319.593
form_enp         -4.135
gv                -9.62
icsd             100028
kp_leng              40
kv               -0.822
mbj_gap          0.0002
mepsx          -426.369
mepsy          -425.156
mepsz            1.0578
mpid           mp-10010
op_gap           0.0001
jid         JVASP-10010
dtype: object
data/jarvis_subset.csv epsx             4.6738
epsy              4.746
epsz             4.7722
fin_en         -103.757
form_enp         -2.086
gv                5.947
icsd              27393
kp_leng              50
kv               16.378
mbj_gap          0.6495
mepsx            3.6685
mepsy            3.7637
mepsz            3.7977
mpid             mp-158
op_gap           0.0221
jid         JVASP-11997
dtype: object
~~~
{: .output}

## Use `glob.glob` to find sets of files whose names match a pattern.

*   In Unix, the term "globbing" means "matching a set of files with a pattern".
*   The most common patterns are:
    *   `*` meaning "match zero or more characters"
    *   `?` meaning "match exactly one character"
*   Python contains the `glob` library to provide pattern matching functionality
*   The `glob` library contains a function also called `glob` to match file patterns
*   E.g., `glob.glob('*.txt')` matches all files in the current directory
    whose names end with `.txt`.
*   Result is a (possibly empty) list of character strings.

~~~
import glob
print('all csv files in data directory:', glob.glob('data/*.csv'))
~~~
{: .python}
~~~
all csv files in data directory: ['data/jarvis_all.csv', 'data/jarvis_subset.csv']
~~~
{: .output}

~~~
print('all PDB files:', glob.glob('*.pdb'))
~~~
{: .python}
~~~
all PDB files: []
~~~
{: .output}

## Use `glob` and `for` to process batches of files.

*   Helps a lot if the files are named and stored systematically and consistently
    so that simple patterns will find the right data.

~~~
for filename in glob.glob('data/jarvis_*.csv'):
    data = pandas.read_csv(filename)
    print(filename, data['gv'].min())
~~~
{: .python}
~~~
data/jarvis_all.csv -9.62
data/jarvis_subset.csv 5.947
~~~
{: .output}

*   This includes all data, as well as per-region data.
*   Use a more specific pattern in the exercises to exclude the whole data set.
*   But note that the minimum of the entire data set is also the minimum of one of the data sets,
    which is a nice check on correctness.

> ## Determining Matches
>
> Which of these files is *not* matched by the expression `glob.glob('data/*as*.csv')`?
>
> 1. `data/gapminder_gdp_africa.csv`
> 2. `data/gapminder_gdp_americas.csv`
> 3. `data/gapminder_gdp_asia.csv`
> 4. 1 and 2 are not matched.
>
> > ## Solution
> >
> > 1 is not matched by the glob.
> {: .solution}
{: .challenge}

> ## Minimum File Size
>
> Modify this program so that it prints the number of records in
> the file that has the fewest records.
>
> ~~~
> import glob
> import pandas
> fewest = ____
> for filename in glob.glob('data/*.csv'):
>     dataframe = pandas.____(filename)
>     fewest = min(____, dataframe.shape[0])
> print('smallest file has', fewest, 'records')
> ~~~
> {: .python}
> Notice that the shape method returns a tuple with
> the number of rows and columns of the data frame.
>
> > ## Solution
> > ~~~
> > import glob
> > import pandas
> > fewest = float('Inf')
> > for filename in glob.glob('data/*.csv'):
> >     dataframe = pandas.read_csv(filename)
> >     fewest = min(fewest, dataframe.shape[0])
> > print('smallest file has', fewest, 'records')
> > ~~~
> > {: .python}
> {: .solution}
{: .challenge}
