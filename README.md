# SwiftRepositories
App example listing all public GitHub repositories written using the Swift language. 

# Development Process

To begin, I created the Service class to parse the API endpoint with the list of repositories written in swift.

I analysed the Json structure, read the API documentation to understand pagination, and created the Repositories View Controller with a collectionView, in which each cell represented a repository. Uppon tap on a cell, the repository fullName is passed to the Detail View Controller, in order to fetch details belonging to this repository.

I created the Repository View Model to handle the API call, store the page fetched, calculate the indexes to load in collection view, append the new repositories to an array and pass data to Repositories View Controller. This was done with a protocol, using the delegate pattern.

I handled connectivity and possible decoding errors by presenting alerts.

The repository list is shown in a collectionView with 1 row, and each repository is represented with its name, its fullName, and the language in which it was written, in this case, Swift.

Then, on repository tapped, the Detail View Controller is presented, and the product's fullName is passed in order to fetch the details, and be presented on interface.

The details for each repository as well as the contributors list are fetched in Detail View Model, and, upon successful completion, data is passed to Detail View Controller through delegate pattern.

Both repositoryDetail and contributors array are received by view controller and passed to Detail View, where UI is populated.

In Detail View, other collection is presented, with each cell representing a contributor, with loginName, aditions, deletions and commits done for this repository. The avatar image is also presented.
All images are cached to reduce network overhead.

The contributor cell also shows the numbers of aditions and deletions done per week. The GitHub website shows this information in a form of a graphic, but it made sense to me to divide the sum of aditions or deletions made throughout the weeks by the total number of weeks.

Both Detail View and the collection representing the contributors list present their data via property observers.

Overall It was a very interesting project, it has been fun to develop. I gave a personal touch, presenting a UI structure that I enjoy, inspired a little bit by GitHub's website.
