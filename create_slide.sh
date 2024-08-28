#!/bin/bash

# Function to get the next slide number
get_next_slide_number() {
    local max_number=0
    for file in slide_*.dart; do
        if [[ $file =~ slide_([0-9]+)\.dart ]]; then
            number="${BASH_REMATCH[1]}"
            if ((number > max_number)); then
                max_number=$number
            fi
        fi
    done
    echo $((max_number + 1))
}

cd lib/slides

# Get the next slide number
next_number=$(get_next_slide_number)

# Create the new file name
new_file="slide_${next_number}.dart"

# Create the content for the new file
cat << EOF > "$new_file"
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide$next_number extends FlutterDeckSlideWidget {
  const Slide$next_number()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/$next_number',
            title: '$next_number',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const Text('$next_number');
      },
    );
  }
}
EOF

echo "Created new file: $new_file"