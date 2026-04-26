# Prayer Talk - Usage Guide

## Getting Started

### Running the App

1. **Check Available Devices**
   ```bash
   flutter devices
   ```

2. **Run on Your Device**
   ```bash
   flutter run
   ```

3. **Run on Specific Platform**
   - Android: `flutter run -d android`
   - iOS: `flutter run -d ios`
   - Web: `flutter run -d chrome`
   - Windows: `flutter run -d windows`

## App Features Guide

### Main Screen (Prayer List)

The main screen displays all available prayers organized by category.

**Features:**
- **Category Filter**: Tap on category chips at the top to filter prayers
- **Prayer Cards**: Each card shows:
  - Prayer title
  - Category
  - Number of lines
  - Icon indicating it's a Bible prayer
- **Tap to Play**: Tap any prayer card to open the player screen
- **About Button**: Floating action button shows app information

### Prayer Player Screen

This is where the magic happens - the call-and-response prayer experience.

**Understanding the Line Types:**

1. **Leader (Blue with Mic Icon)**
   - The app speaks this line
   - This is the call/prompt part
   - Listen and prepare for the response

2. **Response (Green with Voice Icon)**
   - After the leader speaks, there's a pause
   - This is YOUR turn to respond
   - The pause duration is customizable (default 3 seconds)
   - You can pray this line out loud or silently

3. **All (Purple with Groups Icon)**
   - Everyone prays together
   - The app speaks it, and you can join in
   - Usually used for conclusions like "Amen"

**Controls:**

- **Play Button** (Large FAB): Start the prayer
- **Pause Button**: Pause at any point
- **Stop Button**: Stop and reset to beginning
- **Settings Icon**: Access speech controls

**Settings:**

- **Speech Rate**: Control how fast the voice speaks (0.1 - 1.0)
  - Slower (0.1-0.4): Better for meditation and following along
  - Normal (0.5): Default, comfortable pace
  - Faster (0.6-1.0): For familiar prayers
  
- **Volume**: Control the voice volume (0-100%)
  - Adjust based on your environment
  - Set lower for quiet meditation
  - Set higher when doing other activities

**Visual Feedback:**

- **Current Line Highlighting**: The active line is highlighted with:
  - Larger card with elevated shadow
  - Color-coded background matching line type
  - "Now playing..." indicator
  - Bold text

**Completion:**

When the prayer finishes, you'll see a completion dialog with options:
- **Close**: Return to the player screen
- **Pray Again**: Restart the prayer immediately

## Use Cases

### 1. Meditation and Focus
- Use slower speech rate (0.3-0.4)
- Sit comfortably and follow along
- Close your eyes during response pauses
- Use as a guided meditation

### 2. Multitasking Prayer
- Set comfortable speech rate (0.5)
- Start the prayer while:
  - Cooking
  - Cleaning
  - Exercising
  - Driving (be safe!)
  - Doing chores
- Respond during pauses naturally

### 3. Learning Prayers
- Use slower speech rate
- Follow along with the text
- Repeat multiple times
- Great for memorization

### 4. Accessibility
- For those with vision difficulties
- For those who struggle with reading
- For elderly users
- For children learning prayers

## Tips for Best Experience

1. **Find Your Pace**: Experiment with different speech rates to find what works for you

2. **Regular Practice**: Use the app daily for:
   - Morning prayers
   - Evening prayers
   - Before meals
   - During stressful times

3. **Quiet Environment**: For best audio quality, use in a quiet space or with headphones

4. **Pause and Reflect**: Feel free to pause between lines to reflect on the words

5. **Add to Routine**: Integrate into your daily routine:
   - Morning: "Morning Prayer"
   - Difficult times: "Psalm 23" or "Psalm 91"
   - Anytime: "The Lord's Prayer"

## Technical Notes

### Text-to-Speech Quality

The voice quality depends on:
- Your device's installed TTS engines
- Android: Google TTS (usually pre-installed)
- iOS: Built-in Siri voices
- Web: Browser's speech synthesis
- Windows: Microsoft Speech Platform

### Improving Voice Quality

**Android:**
1. Go to Settings > System > Language & Input
2. Select "Text-to-speech output"
3. Download high-quality voices

**iOS:**
1. Settings > Accessibility > Spoken Content
2. Select "Voices"
3. Download enhanced quality voices

**Windows:**
1. Settings > Time & Language > Speech
2. Manage voices
3. Download additional voices

## Troubleshooting

### No Sound
- Check device volume
- Ensure TTS is enabled on your device
- Try adjusting volume in app settings
- Restart the app

### Voice Sounds Robotic
- Download better quality TTS voices
- Adjust speech rate to slower settings
- Some platforms have better voices than others

### App Doesn't Pause
- Tap the pause button (it should change to a pause icon when playing)
- If stuck, use the stop button and restart

### Text Not Following Along
- Ensure you're on the prayer player screen (not the list)
- The current line highlights automatically as it plays
- Scroll if needed to see the current line

## Adding More Prayers

Currently, prayers are built into the app. Future updates will allow:
- Custom prayer creation
- Community-contributed prayers
- Importing prayers from files
- Creating personal prayer collections

## Privacy

- This app works completely offline (after initial install)
- No data is collected or sent to servers
- No account required
- All prayers stored locally

## Support

For issues, questions, or suggestions:
- Check the README.md file
- Create an issue on GitHub (if repository is public)
- Contact the developer

---

**May your prayers be blessed!**
