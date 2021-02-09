# Standing Orders

UK House of Commons public Standing Orders Dataset, Version 1.2.0, repurposed from the [ParlRulesData Project](https://parlrulesdata.org/). 2020.

Goet, Niels D., Thomas G. Fleming, and Radoslaw Zubek. Forthcoming. ‘Procedural Change in the UK House of Commons, 1811-2015’. Legislative Studies Quarterly.

## Setting up

### Run:
``` psql standing_orders < db/schema/setup.sql ```

### Edit the revision set model to change:

```
has_many :fragment_versions, -> { order( ordinality: :asc )}
has_many :order_versions, -> { order( ordinality: :asc )}
```
to:

```
has_many :fragment_versions, -> { order( parlrules_identifier: :asc )}
has_many :order_versions, -> { order( parlrules_identifier: :asc )}

# Run:

``` rake setup ```

### Edit the revision set model to change:

```
has_many :fragment_versions, -> { order( parlrules_identifier: :asc )}
has_many :order_versions, -> { order( parlrules_identifier: :asc )}
```

to:

```
has_many :fragment_versions, -> { order( ordinality: :asc )}
has_many :order_versions, -> { order( ordinality: :asc )}
```

### Run:
``` psql standing_orders < db/schema/tidy.sql ```


