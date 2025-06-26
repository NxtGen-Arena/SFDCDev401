# Aura Application Event

<h2>Steps for creating Application Event </h2>

Step 1: Define Application Event
Step 2: Trainee Search Component
Step 3: Handle Event

<h2> 📂 Project Structure </h2>

![image](https://github.com/user-attachments/assets/7cfd6626-26d5-4c6e-bbae-5c8e57c209d6)

<h2>Component structure </h2>

|COmponent|Details|
|-----|----|
|traineeSelectedAppEvent.evt| This event is defined at the app level using type="APPLICATION". It can now be fired from one component and handled anywhere else in the app—even unrelated components.”
|traineeSearch.cmp|Fetches a list of trainees from Apex using loadTrainees() and displays them in cards. Each card has a ‘Select’ button, which fires an Application Event carrying the traineeId. No parent-child relationship needed. The power of this design lies in its reusability!
|enrollmentSummary.cmp|The enrollmentSummary component listens for the traineeSelectedAppEvent. When it receives it, the controller extracts the traineeId and delegates to a helper function to fetch enrollments. Those are displayed in a styled Lightning layout.

<h2>🧪 Testing the component</h2>

1. Open a Lightning Page and drag both traineeSearch and enrollmentSummary components onto the canvas.
2. Save & Activate.
3. Preview in App — selecting a trainee should update the enrollment summary via app event.

