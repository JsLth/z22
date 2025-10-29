# z22 1.1.0

0 errors | 0 warnings | 1 note

* This is a resubmission.



# z22 1.0.0

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

> Please provide a link to the used webservices to the description field of your DESCRIPTION file in the form <http:...> or <https:...> with angle brackets for auto-linking and no space after 'http:' and 'https:'.
For more details: 
> <https://contributor.r-project.org/cran-cookbook/description_issues.html#references>

The package does not interface a web _service_. It uses pre-processed data
from https://www.zensus2022.de/, which is already linked in the description.
The pre-processed data are stored on an external data repository, but I don't
feel like linking it in the package description would be helpful to users.
It's just raw data; the background to these data is described on
https://www.zensus2022.de/. I link the data repository in the README and I also
added a note to the Details section in z22_data.Rd to make it clearer that
data are downloaded from a data repository.
