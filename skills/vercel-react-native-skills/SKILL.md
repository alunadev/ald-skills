---
name: applying-react-native-best-practices
description: React Native and Expo best practices for building performant mobile apps. Use this skill when building React Native or Expo applications, optimizing list performance with FlashList, implementing animations with Reanimated, configuring native modules, routing with expo-router, managing state in mobile contexts, or working in monorepo setups with Expo. Apply proactively when writing FlatList, useEffect for animations, TouchableOpacity, or setting up navigation — these patterns prevent common mobile performance pitfalls.
---

# React Native Best Practices

Mobile performance is less forgiving than web. A poorly optimized list causes visible jank at 60fps. An unoptimized animation drops frames. A misconfigured Reanimated worklet crashes. These guidelines from Vercel Engineering cover the 8 most impactful categories for React Native + Expo production apps.

## Workflow

1. **Check list implementation first** — FlashList vs FlatList is the highest-impact decision
2. **Audit animations** — confirm they run on the UI thread, not JS thread
3. **Verify navigation** — native stack + native tabs, not JS-based navigators
4. **Review state subscriptions** — minimize what causes re-renders
5. **Check monorepo setup** — native dependencies in the right package

---

## 1. List Performance — CRITICAL

The most common source of React Native jank is inefficient list rendering.

### Use FlashList Over FlatList

`@shopify/flash-list` is a drop-in replacement for `FlatList` that uses recycling to maintain constant memory usage regardless of list size. FlatList allocates new components; FlashList reuses them.

```tsx
import { FlashList } from '@shopify/flash-list';

<FlashList
  data={items}
  renderItem={({ item }) => <ItemRow item={item} />}
  estimatedItemSize={56} // critical for performance — measure real items
  keyExtractor={(item) => item.id}
/>
```

### Memoize List Items

Wrap list item components in `React.memo` and pass stable props. Re-rendering 1000 list items because the parent updated is expensive.

```tsx
const ItemRow = React.memo(({ item, onPress }: ItemProps) => {
  return (
    <Pressable onPress={() => onPress(item.id)}>
      <Text>{item.name}</Text>
    </Pressable>
  );
});
```

### Stable Callbacks for List Items

Create callbacks with `useCallback` or pass pre-bound functions to avoid breaking memoization on every render.

```tsx
// Creates a new function every render — breaks memoization:
<FlashList renderItem={({ item }) => <ItemRow onPress={() => handlePress(item.id)} />} />

// Stable callback:
const handleItemPress = useCallback((id: string) => {
  navigation.navigate('Item', { id });
}, [navigation]);
<FlashList renderItem={({ item }) => <ItemRow onPress={handleItemPress} id={item.id} />} />
```

### No Inline Styles in List Items

Inline style objects (`style={{ padding: 16 }}`) create new object references on every render, causing unnecessary style recalculations.

```tsx
// Bad — new object every render:
<View style={{ padding: 16, backgroundColor: '#fff' }}>

// Good — StyleSheet creates optimized style objects:
const styles = StyleSheet.create({
  container: { padding: 16, backgroundColor: '#fff' },
});
<View style={styles.container}>
```

---

## 2. Animation — HIGH

React Native has two threads: JS and UI. Animations that run on the JS thread cause jank because they block during layout calculations. Reanimated 2+ runs animations on the UI thread.

### Animate GPU-Composited Properties Only

On React Native, animate only `transform` and `opacity` for smooth 60fps. Animating `width`, `height`, or `backgroundColor` is expensive.

```tsx
import Animated, { useSharedValue, useAnimatedStyle, withSpring } from 'react-native-reanimated';

const translateY = useSharedValue(0);

const animatedStyle = useAnimatedStyle(() => ({
  transform: [{ translateY: translateY.value }],
}));

// Trigger animation on the UI thread:
translateY.value = withSpring(100);
```

### useDerivedValue for Computed Animation Values

Compute derived animation values on the UI thread using `useDerivedValue`, not in JS-thread calculations.

```tsx
import { useDerivedValue, useSharedValue } from 'react-native-reanimated';

const progress = useSharedValue(0);
const opacity = useDerivedValue(() => progress.value > 0.5 ? 1 : 0);
```

### Gesture.Tap Over Pressable for Complex Gestures

For complex gesture handling, use `Gesture.Tap()` from `react-native-gesture-handler` instead of `Pressable`. It runs on the UI thread and composes with other gestures.

```tsx
import { Gesture, GestureDetector } from 'react-native-gesture-handler';

const tap = Gesture.Tap().onEnd(() => {
  runOnJS(handlePress)();
});

<GestureDetector gesture={tap}>
  <Animated.View style={animatedStyle}>...</Animated.View>
</GestureDetector>
```

---

## 3. Navigation — HIGH

JS-based navigators run on the JS thread — they jank during complex renders. Native navigators run on the native thread.

### Native Stack Over JS Stack

Use `@react-navigation/native-stack` (wraps iOS UINavigationController / Android Fragment) over `@react-navigation/stack` (JS-based, more customizable but slower).

```tsx
import { createNativeStackNavigator } from '@react-navigation/native-stack';
const Stack = createNativeStackNavigator();

<Stack.Navigator>
  <Stack.Screen name="Home" component={HomeScreen} />
</Stack.Navigator>
```

### Native Tabs Over JS Tabs

Use `@react-navigation/bottom-tabs` with the `tabBarComponent` from `react-native-bottom-tabs` or `expo-router`'s native tabs.

With expo-router (recommended):

```tsx
// app/(tabs)/_layout.tsx
import { Tabs } from 'expo-router';

export default function TabLayout() {
  return (
    <Tabs screenOptions={{ tabBarActiveTintColor: '#007AFF' }}>
      <Tabs.Screen name="index" options={{ title: 'Home' }} />
      <Tabs.Screen name="profile" options={{ title: 'Profile' }} />
    </Tabs>
  );
}
```

---

## 4. UI Patterns — HIGH

### expo-image Over Image

Use `expo-image` instead of React Native's built-in `Image`. It supports caching, blurhash placeholders, better memory management, and animated images.

```tsx
import { Image } from 'expo-image';

<Image
  source={{ uri: user.avatarUrl }}
  placeholder={blurhash}
  contentFit="cover"
  style={{ width: 48, height: 48, borderRadius: 24 }}
/>
```

### Pressable Over TouchableOpacity

`Pressable` is more flexible and supports `style` as a function for pressed states. `TouchableOpacity` is legacy.

```tsx
<Pressable
  onPress={handlePress}
  style={({ pressed }) => [
    styles.button,
    pressed && styles.buttonPressed,
  ]}
>
  <Text>Press me</Text>
</Pressable>
```

### Native Modals

Use React Navigation's modal presentation or `expo-router`'s modal routes for sheets and dialogs. Avoid custom modal implementations that use absolute positioning.

```tsx
// expo-router — modal route:
// app/modal.tsx
export default function Modal() {
  return (
    <View>
      <Text>Modal content</Text>
    </View>
  );
}
// app/_layout.tsx
<Stack.Screen name="modal" options={{ presentation: 'modal' }} />
```

### SafeArea Handling

Use `SafeAreaView` from `react-native-safe-area-context` — not the built-in `SafeAreaView`, which doesn't update on orientation changes.

```tsx
import { SafeAreaView } from 'react-native-safe-area-context';

export default function Screen() {
  return (
    <SafeAreaView edges={['top', 'bottom']} style={{ flex: 1 }}>
      <ScreenContent />
    </SafeAreaView>
  );
}
```

---

## 5. State Management — MEDIUM

### Minimize Subscriptions

Only subscribe to the slice of state your component needs. Subscribing to the whole store causes re-renders on any state change.

```tsx
// Bad — re-renders on any store change:
const store = useStore();

// Good — re-renders only when user.name changes:
const userName = useStore((state) => state.user.name);
```

### Dispatcher Pattern

Define typed action dispatchers instead of calling `setState` directly. This centralizes business logic and makes state changes traceable.

```tsx
const incrementCount = () => setCount(c => c + 1);
const resetCount = () => setCount(0);
```

---

## 6. Rendering — MEDIUM

### Text Always in Text Component

Every string rendered in React Native must be inside a `<Text>` component. Strings outside `<Text>` crash in production.

```tsx
// Bad — crashes:
<View>{'Hello'}</View>

// Good:
<View><Text>Hello</Text></View>
```

### No Falsy && Renders

`{count && <Badge count={count} />}` renders `0` (the number zero) as text when count is 0. Use explicit boolean checks.

```tsx
// Bad — renders "0" when count is 0:
{count && <Badge count={count} />}

// Good:
{count > 0 && <Badge count={count} />}
// or:
{!!count && <Badge count={count} />}
```

---

## 7. Monorepo — MEDIUM

### Native Dependencies in App Package

In a monorepo, native dependencies (`react-native-reanimated`, `expo-image`, `react-native-gesture-handler`) must be installed in the app's `package.json`, not a shared package. The Metro bundler needs them at the app level.

```
packages/
  shared-ui/          # no native deps here
    package.json
  mobile-app/         # native deps go here
    package.json      # react-native-reanimated, expo-image, etc.
```

### Single Version Across Packages

Ensure each native package has exactly one version installed across the monorepo. Multiple versions of the same native library cause cryptic runtime errors.

Use workspace version management or `yarn dedupe` / `pnpm dedupe` to enforce single versions.

---

## 8. Configuration — LOW

### Config Plugins for Fonts

Use Expo config plugins to configure native fonts instead of manual native setup. Config plugins regenerate native files on every `expo prebuild`.

```json
// app.json
{
  "expo": {
    "plugins": [
      ["expo-font", { "fonts": ["./assets/fonts/Inter-Regular.ttf"] }]
    ]
  }
}
```

### Design System Folder Structure

Organize your design system components to separate platform-specific from shared:

```
components/
  ui/               # platform-agnostic primitives
    Button/
      Button.tsx
      Button.styles.ts
  native/           # React Native specific
    NativeButton.tsx
```

## Quality Checklist

- [ ] Lists use FlashList with `estimatedItemSize`
- [ ] List items wrapped in `React.memo`
- [ ] Animations use `useSharedValue` + `useAnimatedStyle` (Reanimated)
- [ ] Only `transform` and `opacity` animated
- [ ] Navigation uses `createNativeStackNavigator`
- [ ] No `TouchableOpacity` — replaced with `Pressable`
- [ ] `SafeAreaView` from `react-native-safe-area-context`
- [ ] No inline styles in list items
- [ ] All rendered strings inside `<Text>` components

## Common Antipatterns

- `FlatList` for lists over 50 items
- Animating `backgroundColor`, `width`, or `height`
- `style={{ ... }}` inline in list item renders
- `{count && <Component />}` instead of `{count > 0 && <Component />}`
- Native dependencies in a shared workspace package
