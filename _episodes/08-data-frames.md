---
title: "Pandas DataFrames"
teaching: 15
exercises: 15
questions:
- "How can I do statistical analysis of tabular data?"
objectives:
- "Select individual values from a Pandas dataframe."
- "Select entire rows or entire columns from a dataframe."
- "Select a subset of both rows and columns from a dataframe in a single operation."
- "Select a subset of a dataframe by a single Boolean criterion."
keypoints:
- "Use `DataFrame.iloc[..., ...]` to select values by integer location."
- "Use `:` on its own to mean all columns or all rows."
- "Select multiple columns or rows using `DataFrame.loc` and a named slice."
- "Result of slicing can be used in further operations."
- "Use comparisons to select data based on value."
- "Select values or NaN using a Boolean mask."
---

## Note about Pandas DataFrames/Series

A [DataFrame][pandas-dataframe] is a collection of [Series][pandas-series];
The DataFrame is the way Pandas represents a table, and Series is the data-structure
Pandas use to represent a column.

Pandas is built on top of the [Numpy][numpy] library, which in practice means that
most of the methods defined for Numpy Arrays apply to Pandas Series/DataFrames.

What makes Pandas so attractive is the powerful interface to access individual records
of the table, proper handling of missing values, and relational-databases operations
between DataFrames.

## Selecting values

To access a value at the position `[i,j]` of a DataFrame, we have two options, depending on
what is the meaning of `i` in use.
Remember that a DataFrame provides a *index* as a way to identify the rows of the table;
a row, then, has a *position* inside the table as well as a *label*, which
uniquely identifies its *entry* in the DataFrame.

## Use `DataFrame.iloc[..., ...]` to select values by their (entry) position

*   Can specify location by numerical index analogously to 2D version of character selection in strings.

~~~
import pandas
data_all = pandas.read_csv('data/jarvis_all.csv', index_col='formula')
print(data_all.iloc[0, 0])
~~~
{: .language-python}
~~~
21.0673
~~~
{: .output}

## Use `DataFrame.loc[..., ...]` to select values by their (entry) label.

*   Can specify location by row name analogously to 2D version of dictionary keys.

~~~
data_subset = pandas.read_csv('data/jarvis_subset.csv', index_col='formula')
print(data_subset.loc["As", "epsx"])
~~~
{: .language-python}
~~~
21.0673
~~~
{: .output}
## Use `:` on its own to mean all columns or all rows.

*   Just like Python's usual slicing notation.

~~~
print(data_subset.loc["As", :])
~~~
{: .language-python}
~~~
epsx            21.0673
epsy            29.1228
epsz            17.6066
fin_en         -12.2422
form_enp          0.025
gv               19.993
icsd             609832
kp_leng              65
kv               34.556
mbj_gap          0.6495
mepsx           15.0619
mepsy           14.9875
mepsz           12.4788
mpid             mp-158
op_gap           0.0221
jid         JVASP-11997
Name: As, dtype: object
~~~
{: .output}

*   Would get the same result printing `data_subset.loc["As"]` (without a second index).

~~~
print(data_subset.loc[:, "epsx"])
~~~
{: .language-python}
~~~
formula
As       21.0673
MoO3      6.3933
AgI       6.0838
ZrBrN     7.0316
InBr3     4.6738
Name: epsx, dtype: float64
~~~
{: .output}

*   Would get the same result printing `data_subset["epsx"]`
*   Also get the same result printing `data_subset.epsx` (since it's a column name)

## Select multiple columns or rows using `DataFrame.loc` and a named slice.

~~~
data_all_sorted = data_all.sort_index()
print(data_all_sorted.loc['BaO':'BaS2', 'epsx':'epsz'])
~~~
{: .language-python}
~~~
            epsx     epsy     epsz
formula
BaO       5.0126   5.0126   4.4529
BaO2      3.6134   3.6709   3.9081
BaP3     11.5224  11.1754  10.7349
BaPbO3    8.9412   9.0321   8.9705
BaPdS2   10.5437   9.2255   7.9498
BaS2      5.1928   6.7944   4.8265
~~~
{: .output}

In the above code, we discover that **slicing using `loc` is inclusive at both
ends**, which differs from **slicing using `iloc`**, where slicing indicates
everything up to but not including the final index.


## Result of slicing can be used in further operations.

*   Usually don't just print a slice.
*   All the statistical operators that work on entire dataframes
    work the same way on slices.
*   E.g., calculate max of a slice.

~~~
print(data_all_sorted.loc['BaO':'BaS2', 'epsx':'epsz'].max())
~~~
{: .language-python}
~~~
epsx    11.5224
epsy    11.1754
epsz    10.7349
dtype: float64
~~~
{: .output}

~~~
print(data_all_sorted.loc['BaO':'BaS2', 'epsx':'epsz'].min())
~~~
{: .language-python}
~~~
epsx    3.6134
epsy    3.6709
epsz    3.9081
dtype: float64
~~~
{: .output}

## Use comparisons to select data based on value.

*   Comparison is applied element by element.
*   Returns a similarly-shaped dataframe of `True` and `False`.

~~~
# Use a subset of data to keep output readable.
subset = data_all_sorted.loc['BaO':'BaS2', 'epsx':'epsz']
print('Subset of data:\n', subset)

# Which values were greater than 10000 ?
print('\nWhere are values large?\n', subset > 6)
~~~
{: .language-python}
~~~
ubset of data:
             epsx     epsy     epsz
formula
BaO       5.0126   5.0126   4.4529
BaO2      3.6134   3.6709   3.9081
BaP3     11.5224  11.1754  10.7349
BaPbO3    8.9412   9.0321   8.9705
BaPdS2   10.5437   9.2255   7.9498
BaS2      5.1928   6.7944   4.8265

Where are values large?
           epsx   epsy   epsz
formula
BaO      False  False  False
BaO2     False  False  False
BaP3      True   True   True
BaPbO3    True   True   True
BaPdS2    True   True   True
BaS2     False   True  False
~~~
{: .output}

## Select values or NaN using a Boolean mask.

*   A frame full of Booleans is sometimes called a *mask* because of how it can be used.

~~~
mask = subset > 6
print(subset[mask])
~~~
{: .language-python}
~~~
            epsx     epsy     epsz
formula
BaO          NaN      NaN      NaN
BaO2         NaN      NaN      NaN
BaP3     11.5224  11.1754  10.7349
BaPbO3    8.9412   9.0321   8.9705
BaPdS2   10.5437   9.2255   7.9498
BaS2         NaN   6.7944      NaN
~~~
{: .output}

*   Get the value where the mask is true, and NaN (Not a Number) where it is false.
*   Useful because NaNs are ignored by operations like max, min, average, etc.

~~~
print(subset[subset > 6].describe())
~~~
{: .language-python}
~~~
            epsx       epsy       epsz
count   3.000000   4.000000   3.000000
mean   10.335767   9.056850   9.218400
std     1.303102   1.792204   1.409002
min     8.941200   6.794400   7.949800
25%     9.742450   8.472675   8.460150
50%    10.543700   9.128800   8.970500
75%    11.033050   9.712975   9.852700
max    11.522400  11.175400  10.734900
~~~
{: .output}

## Select-Apply-Combine operations

Pandas vectorizing methods and grouping operations are features that provide users
much flexibility to analyze their data.

For instance, let's say we want to calculate the
[birefringence](https://en.wikipedia.org/wiki/Birefringence) and
determine materials that are optically isotropic.


1.  Firstly we isolate a dataframe with just the dielectric constants.
2.  We then take the difference of the square root and find the
    maximum. An optically isotropic material should be 0. For example,
    Silicon should be optically isotropic.


~~~
import numpy

dielectric_sq = data_all[['epsx', 'epsy', 'epsz', 'epsx']].apply(numpy.sqrt)
print(dielectric_sq.iloc[:5])
~~~
{: .language-python}
~~~
            epsx      epsy      epsz      epsx
formula
As       4.589913  5.396554  4.196022  4.589913
MoO3     2.528498  2.635640  2.525787  2.528498
AgI      2.466536  2.466536  2.562265  2.466536
ZrBrN    2.651716  2.512509  2.286351  2.651716
InBr3    2.161897  2.178532  2.184537  2.161897
~~~
{: .output}
Two of the entries for Silicon have low birefringence.
~~~
birefringence = dielectric_sq.diff(axis=1).aggregate('max', axis=1)
print(birefringence.iloc[10:20])
print()
print(birefringence.loc["Si"])
~~~
{: .language-python}
~~~
formula
VOF3         0.193174
ZnCl2        0.002078
ScHO2        0.026299
Zr(MoO4)2    0.168030
CoF2         0.984077
RbPS3        0.063275
BeO          0.000000
CaCl2        0.030760
SrClF        0.018030
SrBrF        0.028253
dtype: float64

formula
Si    0.122102
Si    0.000000
Si    0.000010
Si    0.427006
Si    0.200976
dtype: float64
~~~
{: .output}
To find the optically isotropic materials use
~~~
isotropic = birefringence[birefringence < 1e-5]
print(isotropic[:10])
~~~
{: .language-python}
~~~
formula
BeO         0.0
SrCl2       0.0
NbSbRu      0.0
K3MoF6      0.0
HfVF6       0.0
MoF6        0.0
Rb2SnBr6    0.0
Sr3BiN      0.0
LiMgBi      0.0
CsK2Sb      0.0
dtype: float64
~~~
{: .output}


> ## Selection of Individual Values
>
> Assume Pandas has been imported into your notebook
> and the JARVIS data has been loaded:
>
> ~~~
> import pandas
>
> df = pandas.read_csv('data/jarvis_all.csv', index_col='formula')
> ~~~
> {: .language-python}
>
> Write an expression to find the formation energy per atom for BeO
{: .challenge}
>
> > ## Solution
> > The selection can be done by using the labels for both the row ("BeO") and the column ("form_enp"):
> > ~~~
> > print(df.loc['BeO', 'form_enp'])
> > ~~~
> > {: .language-python}
> > The output is
> > ~~~
> > -3.025
> > ~~~
> >{: .output}
> {: .solution}
{: .challenge}

> ## Extent of Slicing
>
> 1.  Do the two statements below produce the same output?
> 2.  Based on this,
>     what rule governs what is included (or not) in numerical slices and named slices in Pandas?
>
> ~~~
> print(data_all.iloc[0:2, 0:2])
> print(data_all.loc['As':'MoO3', 'epsx':'epsz'])
> ~~~
> {: .language-python}
>
{: .challenge}
>
> > ## Solution
> > No, they do not produce the same output! The output of the first statement is:
> > ~~~
> >             epsx     epsy
> > formula
> > As       21.0673  29.1228
> > MoO3      6.3933   6.9466
> > ~~~
> >{: .output}
> > The second statement gives:
> > ~~~
> >             epsx     epsy     epsz
> > formula
> > As       21.0673  29.1228  17.6066
> > MoO3      6.3933   6.9466   6.3796
> > ~~~
> >{: .output}
> > Clearly, the second statement produces an additional column and an additional row compared to the first statement.
> > What conclusion can we draw? We see that a numerical slice, 0:2, *omits* the final index (i.e. index 2)
> > in the range provided,
> > while a named slice, 'epsx':'epsz', *includes* the final element.
> {: .solution}
{: .challenge}

> ## Reconstructing Data
>
> Explain what each line in the following short program does:
> what is in `first`, `second`, etc.?
>
> ~~~
> first = pandas.read_csv('data/jarvis_all.csv', index_col='formula')
> second = first[first.index.str.contains('Si')]
> third = second.drop('Si')
> third.to_csv('result.csv')
> ~~~
> {: .language-python}
{: .challenge}
>
> > ## Solution
> > 1. Read in data
> > 2. Only include materials with silicon
> > 3. Remove materials that are pure silicon
> > 4. Save data to a CSV file
> {: .solution}
{: .challenge}

> ## Selecting Indices
>
> Explain in simple terms what `idxmin` and `idxmax` do in the short program below.
> When would you use these methods?
>
> ~~~
data_all = pandas.read_csv('data/jarvis_all.csv')
dielec = data_all.loc[:, 'epsx':'epsz']
print(dielec.idxmin())
print(dielec.idxmax())
> ~~~
> {: .language-python}
{: .challenge}
>
> > ## Solution
> > For each column in `data`, `idxmin` will return the index value corresponding to each column's minimum;
> > `idxmax` will do accordingly the same for each column's maximum value.
> >
> > You can use these functions whenever you want to get the row index of the minimum/maximum value and not the actual minimum/maximum value.
> {: .solution}
{: .challenge}




[pandas-dataframe]: https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.html
[pandas-series]: https://pandas.pydata.org/pandas-docs/stable/generated/pandas.Series.html
[numpy]: http://www.numpy.org/
