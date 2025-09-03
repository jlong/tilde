# CSS Style Guide

We always use the latest version of TailwindCSS for all CSS.

### Multi-line CSS classes in markup

- We use a unique multi-line formatting style when writing Tailwind CSS classes in HTML markup and React, where the classes for each responsive size are written on their own dedicated line.
- The top-most line should be the smallest size (no responsive prefix). Each line below it should be the next responsive size up.
- Each line of CSS classes should be aligned vertically.
- focus and hover classes should be on their own additional dedicated lines.
- If there are any custom CSS classes being used, those should be included at the start of the first line.
- Use a `cn` function to merge classes. If no such function exists create one that is implemented with tailwind-merge and clsx libraries
- If classes for a component are complex, create a `style` object that has states as keys with associated classes as values
- Always refer to the Tailwind configuration in the project for color names

**Example of multi-line Tailwind CSS classes:**

```
<div className={cn(
  "custom-cta",
  "bg-gray-50 dark:bg-gray-900 p-4 rounded cursor-pointer w-full",
  "hover:bg-gray-100 dark:hover:bg-gray-800",
  "sm:p-8 sm:font-medium",
  "md:p-10 md:text-lg",
  "lg:p-12 lg:text-xl lg:font-semibold lg:2-3/5",
  "xl:p-14 xl:text-2xl",
  "2xl:p-16 2xl:text-3xl 2xl:font-bold 2xl:w-3/4"
  disabled && "opacity-40"
)}>
  I'm a call-to-action!
</div>
```
