#!/usr/bin/awk -f

{
  print $0
}

/^parameters:/ {
  while (getline) {
    print $0
    if ($0 ~ /^\w/) { break }
    if ($1 == "environment:") { environment = $2 }
  }
}

END {
  if (environment) {
    printf("environment: %s\n", environment)
  }
}
