# Component Init event with multiple nested components

🔧 COMPONENT BREAKDOWN:

|Component	|Description|
|---------|--------|
|courseTile	|Represents a single course (card layout).
|courseTiles|	A container that holds multiple courseTile components.
|courseBrowser|	Parent container that includes search/filter logic and displays courseTiles. Main container that:Calls Apex to fetch courses & Passes them to courseTiles
