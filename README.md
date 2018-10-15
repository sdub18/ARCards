# ARCards
Designed in Swift, this application can render 3D content on top of a 3D object such as a business card or University ID using ARKit 2.0. Using image tracking, the virtual content is then able to be interacted with and used to display more content that the business card could not display (This includes videos, audio recordings, embedded links, and others.)

https://s3.amazonaws.com/hackumass-vi/project/AR%20Cards.PNG?1539505366

# What it Does
Our project uses ARKit's 2D Image Recognition Software to layer 3D virtual content on top of items such as business cards, school IDs, and even picture frames. We designed several features in our application that allowed consumers to utilize such items in a more practical way than ever before. Being able to glance videos, receive contact information, and respond to the card holder all with the touch of a button is something business cards have never been able to do before. And even better, There is quite the surprise when you check out the content that arrises when looking at the UMass $10 food cards given to us earlier this weekend :)

# How We Built It
Using ARKit 2.0, SceneKit, SpriteKit, and AVKit, our team combined, text, images, videos, and audio in order to develop a completely immersive experience. All of which business cards and students ID's have never been able to do before. More specifically, we focused on building 3D content using a combination of SpriteKit and SceneKit that was then layered on top of the ARImageRecognition Anchor that was pinned to the photo as soon as the phone recognized the image. From there users were then able to interact with the SCNNodes, sending emails or texting the recipients while also receiving haptic feedback from the device for doing so. This was all tied together with scene kit animation in order to create a really awesome experience.

# Why Did We Build This?
This application was designed during intense 36 hour hackathon at UMass Amherst (HackUMass). This application was then entered into the Hackathon and was awarded best AR / VR Application among 102 Other teams and 1000 hackers total. All in all the project was both fun and exciting as a result each team member received an Oculus GO Headset as a prize.
