import { format } from "date-fns";

function formatDate(date, formater = "dd-MM-yyyy") {
  if (!date) {
    return "";
  } else {
    return format(new Date(date), formater);
  }
}

function inputDate(date) {
  return format(new Date(date), "yyyy-MM-dd");
}

export { formatDate, inputDate };
