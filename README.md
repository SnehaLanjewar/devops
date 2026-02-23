# devops
### docker and kubernetes
kubernetes - Containers + Orchestration
COntainers - portable way to bind multiple lib/dependencies into one.
        - instance of image
        - images are read-only
        - image is made of 5layers
        - after creating container we get 6layers which becomes (R/W) (ephermal or temporary)


Host machine - instance of image is run
Matrix of hell - each component in your app requires different lib/dependency to work on
- after few days you have to upgrade one of the components then it becomes a challenge-networking.
